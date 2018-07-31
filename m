Received: from eggs.gnu.org ([2001:4830:134:3::10]:43993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkVDl-0003I9-JU
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkVDg-0006F2-UK
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:01:53 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:41923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkVDg-0006Ea-Ph
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:01:48 -0400
Received: by mail-oi0-x229.google.com with SMTP id k12-v6so28108177oiw.8
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 07:01:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180731084203.29959-1-laurent@vivier.eu>
References: <20180731084203.29959-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jul 2018 15:01:23 +0100
Message-ID: <CAFEAcA-gZ7tQM=OEirfhK+FSieke-S-bCwzAxyNTs8wX10xeEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 31 July 2018 at 09:42, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 6d9dd5fb9d0e9f4a174f53a0e20a39fbe809c71e:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qobject-2018-07-27-v2' into staging (2018-07-30 09:55:47 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request
>
> for you to fetch changes up to 5d9f3ea0817215ad4baac5aa30414e9ebbaaf0d6:
>
>   linux-user: ppc64: don't use volatile register during safe_syscall (2018-07-31 09:57:43 +0200)
>
> ----------------------------------------------------------------
> Fix safe_syscall() on ppc64 host
> Fix mmap() 0 length error case
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
