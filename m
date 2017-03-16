Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coWwC-00053x-It
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coWwB-0002Vi-G8
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:03:36 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coWwB-0002VU-9u
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:03:35 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t189so50319549wmt.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 08:03:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_G=KNQSitea9sE1pfDDZA7tR9zqFKbm-0KASaT6v6kag@mail.gmail.com>
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<CAFEAcA_G=KNQSitea9sE1pfDDZA7tR9zqFKbm-0KASaT6v6kag@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 15:03:13 +0000
Message-ID: <CAFEAcA_NEg7cCQvut7eBTp=mBMdM_7q9mB2K=mH6SmC9ODodQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 February 2017 at 12:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 February 2017 at 00:21, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
>> This is the v2 of the pull-req for target-mips.
>> The warning treated as error has been fixed and the file is now isolated for mips64el only.
>> Boston has further update to have default -drive to if=ide.

> Please make sure you update the 'Build dependencies' section of
> http://wiki.qemu-project.org/ChangeLog/2.9
> to flag up the new libfdt version dependency to users

Reminder: please update
http://wiki.qemu-project.org/ChangeLog/2.9#Build_dependencies
to mention the new libfdt version dependency.

thanks
-- PMM
