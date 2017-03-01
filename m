Received: from eggs.gnu.org ([2001:4830:134:3::10]:44281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cj6ou-0000lx-UG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cj6ot-0002E5-TQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:09:40 -0500
Date: Thu, 2 Mar 2017 00:09:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170301160931.GA19152@lemon.lan>
References: <20170301152651.16390-1-famz@redhat.com>
	<20170301154513.GC4799@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301154513.GC4799@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Update 049 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Wed, 03/01 16:45, Kevin Wolf wrote:
> Am 01.03.2017 um 16:26 hat Fam Zheng geschrieben:
> > 75cdcd155 improved the error message, which affects the reference
> > output. Let's sync it up.
> > 
> > Note that previously '1kilobyte' was treated like '1k', but now it's an
> > error. Looking at the commit in question, this appears to be intended.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Markus alread sent a fix: 'option: Tweak invalid size error message and
> unbreak iotest 049'

Aha, that's good then.

Fam
