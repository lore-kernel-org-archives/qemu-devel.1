Received: from eggs.gnu.org ([2001:4830:134:3::10]:32949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2OO-0004Z5-Hg
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2OL-0001uH-DF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:09:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gX2OL-0001tD-4M
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:09:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC84BC058CBE
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 11:09:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.ams2.redhat.com [10.36.112.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53EB25C221
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 11:09:22 +0000 (UTC)
Date: Wed, 12 Dec 2018 11:09:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181212110919.GB31033@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] 4.0 changelog open - maintainers update after PULL is
 merged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rather than wait until the feature freeze to fill out the release changelog,
lets try a new approach for 4.0 where we fill it out as code is merged.
I've created a changelog template for 4.0:

  https://wiki.qemu.org/ChangeLog/4.0

Any maintainer who sends a PULL request, should make appropriate additions
to the changelog once their PULL is merged by Peter, if it had any changes
users need to be aware of.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
