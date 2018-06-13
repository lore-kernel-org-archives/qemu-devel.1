Received: from eggs.gnu.org ([2001:4830:134:3::10]:37449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwmB-0001Pn-Gs
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwm8-0004IX-Fd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:48:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55506 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSwm8-0004IT-Ad
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:48:48 -0400
Date: Wed, 13 Jun 2018 11:48:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180613034839.GH15344@xz-mi>
References: <20180612062430.GA15344@xz-mi>
	<20180612064119.GC29380@lemon.usersys.redhat.com>
	<20180612065229.GB15344@xz-mi>
	<20180612070152.GD29380@lemon.usersys.redhat.com>
	<20180612074157.GC15344@xz-mi>
	<CAG7hfcJOGj6eEsDV3D6FMD2UJZNOw_7WxV=9qR5c=VHy4Bcp9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG7hfcJOGj6eEsDV3D6FMD2UJZNOw_7WxV=9qR5c=VHy4Bcp9w@mail.gmail.com>
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: Fam Zheng <famz@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Tue, Jun 12, 2018 at 12:53:36AM -0700, Liviu Ionescu wrote:
> On 12 June 2018 at 10:44:09, Peter Xu (peterx@redhat.com) wrote:
> 
> > But it'll still be good if we can have a single package to play around
> > with. If there is no known way to do, we can try to figure a way out.
> 
> you can take a look at:
> 
> https://github.com/gnu-mcu-eclipse/qemu-build
> 
> the scripts can create the binary distributions for windows, linux and
> macos in one run, with all required libraries and everything.
> 
> the result looks like this:
> 
> https://github.com/gnu-mcu-eclipse/qemu/releases

This might be a bit heavy weighted to me (I would only use that for
debugging purpose basically on single platform, and more frequently),
but still good to know such a project and thank you for your reply!

-- 
Peter Xu
