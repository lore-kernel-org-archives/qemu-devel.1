Received: from eggs.gnu.org ([2001:4830:134:3::10]:40550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1coYDq-0003Lg-GS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1coYDm-0000u5-9c
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:25:54 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:13189)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1coYDm-0000mT-3I
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:25:50 -0400
References: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
	<CAFEAcA_G=KNQSitea9sE1pfDDZA7tR9zqFKbm-0KASaT6v6kag@mail.gmail.com>
	<CAFEAcA_NEg7cCQvut7eBTp=mBMdM_7q9mB2K=mH6SmC9ODodQg@mail.gmail.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <efc923c7-ae6b-a159-b9b8-a35b845f39d5@imgtec.com>
Date: Thu, 16 Mar 2017 16:25:43 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NEg7cCQvut7eBTp=mBMdM_7q9mB2K=mH6SmC9ODodQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

I updated the section before?

Build dependencies

    QEMU now requires a minimum dtc version of 1.4.2.

Do you mean to update it like "dtc (libfdt)"?

Regards,
Yongbok


On 16/03/2017 15:03, Peter Maydell wrote:
> On 23 February 2017 at 12:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 22 February 2017 at 00:21, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
>>> This is the v2 of the pull-req for target-mips.
>>> The warning treated as error has been fixed and the file is now isolated for mips64el only.
>>> Boston has further update to have default -drive to if=ide.
> 
>> Please make sure you update the 'Build dependencies' section of
>> http://wiki.qemu-project.org/ChangeLog/2.9
>> to flag up the new libfdt version dependency to users
> 
> Reminder: please update
> http://wiki.qemu-project.org/ChangeLog/2.9#Build_dependencies
> to mention the new libfdt version dependency.
> 
> thanks
> -- PMM
> 
