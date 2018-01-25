Received: from eggs.gnu.org ([2001:4830:134:3::10]:49835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eejJp-0001TP-OI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eejJm-0003Be-I0
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:20:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eejJm-0003BO-Ct
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:19:58 -0500
Date: Thu, 25 Jan 2018 16:19:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180125151949.wnagap36tytob57l@sirius.home.kraxel.org>
References: <20171116075155.22378-1-ppandit@redhat.com>
	<658ecab6-1f09-0c94-c89e-55f71c37309a@redhat.com>
	<20171117093556.ntseydf7eiboeyww@sirius.home.kraxel.org>
	<20171121131812.GC2434@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121131812.GC2434@work-vm>
Subject: Re: [Qemu-devel] [PATCH v1] ps2: check PS2Queue pointers in
 post_load routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, "Daniel P . Berrange" <berrange@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, Prasad J Pandit <pjp@fedoraproject.org>

  Hi,

> > v1 fixes this bug, v2 doesn't.
> > 
> > So, I'm tempted to just rip out the whole backward compatibility buffer
> > shuffling logic.  Or take v1 of this patch.
> 
> I think v1 is OK.

Ok, finally queueed up v1 for merge.

thanks,
  Gerd
