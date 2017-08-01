Received: from eggs.gnu.org ([2001:4830:134:3::10]:48078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcYCw-000348-VM
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcYCr-0002sO-7u
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:31:38 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:38856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcYCr-0002rt-1C
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:31:33 -0400
Received: by mail-wr0-x229.google.com with SMTP id f21so7583984wrf.5
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 07:31:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170801131618.27332-1-stefanha@redhat.com>
References: <20170801131618.27332-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 15:31:11 +0100
Message-ID: <CAFEAcA-RzsbqAWPc0HZ=hcSwhATiQC3dO5NpDqO4LNc43cQanw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 August 2017 at 14:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170731' into staging (2017-07-31 14:45:42 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to bd6952a391b6f2083d6597386f457f30044e32a3:
>
>   monitor: Reduce handle_qmp_command() tracing overhead (2017-08-01 12:13:07 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Fixes for inconsistencies in the trace event format strings, broken
> trace_event_get_state() usage, and handle_qmp_command() fix.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
