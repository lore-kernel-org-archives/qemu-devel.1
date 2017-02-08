Received: from eggs.gnu.org ([2001:4830:134:3::10]:37469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbbE4-0007pG-Oj
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbbDz-0008Q6-9o
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:00:36 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbbDz-0008Pr-3w
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:00:31 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v186so64704095wmd.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 15:00:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486590191-10949-1-git-send-email-juro.bystricky@intel.com>
References: <1486590191-10949-1-git-send-email-juro.bystricky@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Feb 2017 23:00:09 +0000
Message-ID: <CAFEAcA9GE_4+u847H6MF=_AWywd=O6nFrqLyRKyP9OJ2t-4EMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/1] Nios2: Altera JATAG UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juro Bystricky <juro.bystricky@intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, jurobystricky@hotmail.com, Chris Wulff <crwulff@gmail.com>

On 8 February 2017 at 21:43, Juro Bystricky <juro.bystricky@intel.com> wrote:
> Second version, had to remove a long web link (over 90 chars).

Can we have the version with the URL, please?
Checkpatch isn't infallible, and usually its errors
are more of a "look at this and see if it's fixable"
than an unwaivable requirement.

In this case the URL is clearly useful information
for future readers and it can't be folded, so
the over-long line is fine.

thanks
-- PMM
