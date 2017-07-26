Received: from eggs.gnu.org ([2001:4830:134:3::10]:56649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1daPUR-0006pe-60
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1daPUM-00010E-A0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1daPUM-0000yw-3e
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:48:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3081B13A43
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 16:43:02 +0000 (UTC)
Date: Wed, 26 Jul 2017 12:43:01 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170726164301.GA5109@localhost.localdomain>
References: <1501075650-6971-1-git-send-email-thuth@redhat.com>
	<20170726140208.GO7620@redhat.com>
	<236fd293-5d5e-0436-afc3-599ae9de6f92@redhat.com>
	<ab87e4f9-c270-80ec-ed3d-8b315dfacef8@redhat.com>
	<b9db0cdc-f03c-dfec-cf6a-bd2b004c5c3e@redhat.com>
	<3824bef1-1d90-e22f-03a1-9b66dbe1ccb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3824bef1-1d90-e22f-03a1-9b66dbe1ccb5@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a favicon.ico file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On Wed, Jul 26, 2017 at 04:54:48PM +0200, Paolo Bonzini wrote:
> On 26/07/2017 16:47, Thomas Huth wrote:
> > If you're willing to maintain that "mess", sure, please go ahead! But
> > please remove my SoB, I don't want to be responsible for all those files ;-)
> 
> Changed it to suggested-by then, and pushed. :>
> 
> Please test!
>

I just tested in:

chrome
firefox
konqueror
internet explorer
edge
opera

Looks as expected in those, at least.
