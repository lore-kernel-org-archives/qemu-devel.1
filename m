Received: from eggs.gnu.org ([2001:4830:134:3::10]:56238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhQr-00052f-Ul
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhQo-0003dB-S2
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:21:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyhQo-0003cw-Nr
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:21:46 -0400
References: <6228d029-e799-8aa4-e5f5-68d58fa3268a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fd331f5-5fe4-ca5b-5806-51ee49b70666@redhat.com>
Date: Wed, 21 Mar 2018 12:21:40 -0500
MIME-Version: 1.0
In-Reply-To: <6228d029-e799-8aa4-e5f5-68d58fa3268a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alex Williamson <alex.williamson@redhat.com>, Daniel Berrange <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Corey Minyard <minyard@acm.org>, Jeff Cody <jcody@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, "Jason Wang (jasowang@redhat.com)" <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Samuel Thibault <samuel.thibault@gnu.org>, Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 03/21/2018 10:58 AM, Paolo Bonzini wrote:
> Hi all!
> 
> If you are receiving this email, you have sent a pull request for QEMU
> 2.12!  That's awesome, and some of you have also updated the ChangeLog
> for the upcoming release, which is doubly awesome!  I'm sure Santa will
> put you on the nice list and you can stop reading this email. :)
> 
> Even if you haven't updated the ChangeLog, don't worry, I have done it
> for you.  Please double check because QEMU is too big for one person to
> understand all the changes that were made.

This link is helpful, if you fell in the "I have to keep reading" camp:

https://wiki.qemu.org/ChangeLog/2.12

> [1] If you did update the ChangeLog, you were supposed to stop reading,
> weren't you?

Huh?  /me looks around...
Were you talking to me?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
