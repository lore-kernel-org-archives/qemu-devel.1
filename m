Received: from eggs.gnu.org ([2001:4830:134:3::10]:35578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ep3WM-0006SO-Jy
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 21:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ep3VA-0003Yy-W8
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 21:55:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ep3VA-0003XC-Of
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 21:54:24 -0500
Date: Fri, 23 Feb 2018 10:54:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180223025403.GA31530@lemon.usersys.redhat.com>
References: <151930950662.717.8558573146147214756@bdbb90650ae5>
	<87tvu93vf2.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvu93vf2.fsf@xps13.shealevy.com>
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Support f_flags in statfs
 when available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shea Levy <shea@shealevy.com>
Cc: qemu-devel@nongnu.org

On Thu, 02/22 10:18, Shea Levy wrote:
> Hello,
> 
> These tabs match the existing style of linux-user/syscall.h, should I
> remove them?
> 

In practice, following the style of the surrounding code is usually preferred,
and we ignore these errors in such cases.

Fam
