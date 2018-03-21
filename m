Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyhvD-0001zN-F8
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyhv9-00078T-CL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:53:11 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:45711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eyhv9-00075a-54
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:53:07 -0400
Received: from player746.ha.ovh.net (unknown [10.109.108.243])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id BC9D99A61
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 18:44:13 +0100 (CET)
Date: Wed, 21 Mar 2018 18:41:23 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180321184123.104c7fe5@bahia.lan>
In-Reply-To: <1fd331f5-5fe4-ca5b-5806-51ee49b70666@redhat.com>
References: <6228d029-e799-8aa4-e5f5-68d58fa3268a@redhat.com>
	<1fd331f5-5fe4-ca5b-5806-51ee49b70666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PSA] changelog and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alex Williamson <alex.williamson@redhat.com>, Daniel Berrange <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Corey Minyard <minyard@acm.org>, Jeff Cody <jcody@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, "Jason Wang (jasowang@redhat.com)" <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Samuel Thibault <samuel.thibault@gnu.org>, Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On Wed, 21 Mar 2018 12:21:40 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 03/21/2018 10:58 AM, Paolo Bonzini wrote:
> > Hi all!
> > 
> > If you are receiving this email, you have sent a pull request for QEMU
> > 2.12!  That's awesome, and some of you have also updated the ChangeLog
> > for the upcoming release, which is doubly awesome!  I'm sure Santa will
> > put you on the nice list and you can stop reading this email. :)
> > 
> > Even if you haven't updated the ChangeLog, don't worry, I have done it
> > for you.  Please double check because QEMU is too big for one person to
> > understand all the changes that were made.  
> 
> This link is helpful, if you fell in the "I have to keep reading" camp:
> 
> https://wiki.qemu.org/ChangeLog/2.12
> 
> > [1] If you did update the ChangeLog, you were supposed to stop reading,
> > weren't you?  
> 
> Huh?  /me looks around...
> Were you talking to me?
> 

Heh, same here... I couldn't resist :)

--
Greg
