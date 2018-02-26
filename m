Received: from eggs.gnu.org ([2001:4830:134:3::10]:36453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eq8EX-0006Bj-Pi
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 21:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eq8EU-00078M-Ku
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 21:09:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eq8EU-000780-Fu
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 21:09:38 -0500
Date: Mon, 26 Feb 2018 10:09:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180226020927.GA14573@lemon.usersys.redhat.com>
References: <151953467143.1042.1841095009900086023@bdbb90650ae5>
	<40ca37b5-e835-a8db-524e-92e9efc9c650@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ca37b5-e835-a8db-524e-92e9efc9c650@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 RFC 0/3] util/uri.c: Coding style format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, suhang16@mails.ucas.ac.cn, boxafox@163.com

On Sun, 02/25 21:56, Thomas Huth wrote:
> On 25.02.2018 05:57, no-reply@patchew.org wrote:
> >   LINK    ppc-softmmu/qemu-system-ppc
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [Makefile:193: qemu-system-ppc] Error 1
> > make: *** [Makefile:404: subdir-ppc-softmmu] Error 2
> 
>  Hi Fam,
> 
> Patchew genereted some really weird errors here - linking failed without
> any further explanation. Are there currently any known problems with the
> build bot?

This is the first time I see it too. I have no clue but will keep an eye.

Fam
