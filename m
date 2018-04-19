Received: from eggs.gnu.org ([2001:4830:134:3::10]:49039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9D9u-000305-Rv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9D9p-0003x1-8S
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:15:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1f9D9p-0003w1-3M
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:15:41 -0400
References: <CAGn25ShCZePCkYwxQbe3WdwFTskXMZCo=QeQQyiWFuW3kQE5WA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c9939519-123e-c11d-b008-87147c2122f1@redhat.com>
Date: Thu, 19 Apr 2018 13:15:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAGn25ShCZePCkYwxQbe3WdwFTskXMZCo=QeQQyiWFuW3kQE5WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu 2.10 100% cpu with coreduo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "J-F M." <jfm0555@gmail.com>
Cc: qemu-devel@nongnu.org



On 04/18/2018 12:32 PM, J-F M. wrote:
> Hi,
> FYI
> 100% cpu usage  on kernel 4.15.8
> coreduo 2 cores, address sizes 0 bits virtual.
> no problem with qemu cpu 2.5+.
> 
> regards,
> jfm
> 

Hi jfm,

QEMU is a very large and complex piece of software. Your issue report
here will need to be a little more detailed to have any hope of being
addressed.

- What version of QEMU are you running?
- What are the command line options you are running it with?
- Is the CPU usage always 100%? Only when you do something specific?
Which thing triggers the usage?
- What guest operating system appears to trigger the high usage? what
version is it?
- Any additional observations that might help narrow down the problem?

Etc.

--js
