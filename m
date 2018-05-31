Received: from eggs.gnu.org ([2001:4830:134:3::10]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONpP-0005J3-2u
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONpO-0007di-9N
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:41:19 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:44365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fONpO-0007dV-42
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:41:18 -0400
Received: by mail-oi0-x22b.google.com with SMTP id c128-v6so10270581oig.11
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 06:41:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 14:40:56 +0100
Message-ID: <CAFEAcA_TeHCvdgt+1cHPQQE0EpY0-k9Op76TStm_Jm3XbWe_wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] NUMA queue, 2018-05-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 May 2018 at 00:05, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit e609fa71e89c81fbe2670411be62da95dfb093e0:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-05-29-v1.for-upstream' into staging (2018-05-29 13:01:11 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/numa-next-pull-request
>
> for you to fetch changes up to c35665e1ee3d4344cd5156430ebc92310635f9bd:
>
>   tests: functional tests for QMP command set-numa-node (2018-05-30 13:19:14 -0300)
>
> ----------------------------------------------------------------
> NUMA queue, 2018-05-30
>
> * New command-line option: --preconfig
>   This option allows pausing QEMU and allow the configuration
>   using QMP commands before running board initialization code.
> * New QMP set-numa-node, now made possible because of --preconfig
> * Small update on -numa error messages
>

Applied, thanks.

-- PMM
