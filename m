Received: from eggs.gnu.org ([209.51.188.92]:41655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpdE1-0006l5-0o
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpdDr-00078Q-5U
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:07:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpdDg-0006zB-08
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:07:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85449142BEF
	for <qemu-devel@nongnu.org>; Fri,  1 Feb 2019 18:07:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190128170321.16936-1-dgilbert@redhat.com>
Date: Fri, 01 Feb 2019 19:07:04 +0100
In-Reply-To: <20190128170321.16936-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 28 Jan 2019 17:03:12 +0000")
Message-ID: <87ftt7z8l3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/9] Network announce changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, berrange@redhat.com

git-am gripes:

Applying: net: Introduce announce timer
.git/rebase-apply/patch:159: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: migration: Add announce parameters
Applying: virtio-net: Switch to using announce timer
.git/rebase-apply/patch:20: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: migration: Switch to using announce timer
.git/rebase-apply/patch:309: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: net: Add a network device specific self-announcement ability
Applying: virtio-net: Allow qemu_announce_self to trigger virtio announcements
Applying: qmp: Add announce-self command
.git/rebase-apply/patch:28: new blank line at EOF.
+
.git/rebase-apply/patch:56: new blank line at EOF.
+
warning: 2 lines add whitespace errors.
Applying: hmp: Add hmp_announce_self
Applying: tests: Add a test for qemu self announcments
