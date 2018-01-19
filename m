Received: from eggs.gnu.org ([2001:4830:134:3::10]:51541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecb58-0007Q2-M8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecb57-0004VD-Vj
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:08:02 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:45396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecb57-0004UB-Qm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:08:01 -0500
Received: by mail-ot0-x236.google.com with SMTP id r4so2117801oti.12
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:08:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 18:07:40 +0000
Message-ID: <CAFEAcA9TSh+1uRLECTxoZd5s6=Qs3v--Y2j6cT1PRuJX9fr7yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/19] machine queue, 2018-01-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

On 19 January 2018 at 16:33, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Changes from v1 (2018-01-18):
> * Fix build failure on 32-bit
>
> The following changes since commit 3e5bdc6573edf0585e4085e6a4e349b135abf3b4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-01-19 10:17:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to d6b6abc51dda79a97f2c7bd6652c1940c068f1ec:
>
>   fw_cfg: fix memory corruption when all fw_cfg slots are used (2018-01-19 11:18:51 -0200)
>
> ----------------------------------------------------------------
> machine queue, 2018-01-19
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
