Received: from eggs.gnu.org ([2001:4830:134:3::10]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gIGWd-0002rQ-07
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gIGWZ-0002lM-TY
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:12:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gIGWZ-0002kZ-NR
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:12:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEE942CD7FC
	for <qemu-devel@nongnu.org>; Thu,  1 Nov 2018 17:12:49 +0000 (UTC)
Received: from redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2549F60921
	for <qemu-devel@nongnu.org>; Thu,  1 Nov 2018 17:12:48 +0000 (UTC)
Date: Thu, 1 Nov 2018 17:12:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181101171246.GK23712@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] Maintainer attn for 3.1 release changelog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is that time[1] of the release cycle when maintainers can make a start
on filling in the release changelog info for 3.1. I created the basic
page structure copying from 3.0 :

   https://wiki.qemu.org/ChangeLog/3.1

Anyone who has sent a pull request in this dev cycle should fill in the
info about changes they sent.

Regards,
Daniel

[1] Maybe we should in fact create the changelog pages at the very start
    of each release cycle.

    When Peter sends a mail notifying that a pull request is merged, the
    boilerplate email text could include a reminder & link to the latest
    changelog page to be filled in.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
