Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euJLr-0006EU-7s
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euJLq-0008VJ-HE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:50:31 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euJLq-0008Ut-Bl
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:50:30 -0500
Received: by mail-ot0-x243.google.com with SMTP id 95so8880492ote.5
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 06:50:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <152060671798.1497.3007948970030778281@bdbb90650ae5>
References: <20180309142630.2170-1-laurent@vivier.eu>
	<152060671798.1497.3007948970030778281@bdbb90650ae5>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 14:50:08 +0000
Message-ID: <CAFEAcA8GRaGrdbSczr51Z4mqGhL==9WgUJnN01ixOsA=BGMkiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Fam Zheng <famz@redhat.com>

On 9 March 2018 at 14:45,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:

> Checking PATCH 2/8: target/m68k: implement flognp1...
> ERROR: do not set execute permissions for source files
> #281: FILE: target/m68k/softfloat_fpsp_tables.h
>
> total: 1 errors, 0 warnings, 408 lines checked

Oops. Could you fix the file permissions and resend, please,
Laurent ?

(I don't normally worry about checkpatch issues on pull requests,
but this one seems significant enough to be worth fixing.)

thanks
-- PMM
