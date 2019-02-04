Received: from eggs.gnu.org ([209.51.188.92]:51628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gqcPj-0005K2-0V
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gqcHu-0000ri-Pp
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:19:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gqcHm-0000Yj-CX
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:19:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45785C04959D
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 11:19:28 +0000 (UTC)
Date: Mon, 4 Feb 2019 11:19:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190204111917.GA2680@work-vm>
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<87ftt7z8l3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftt7z8l3.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 0/9] Network announce changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, berrange@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> git-am gripes:

Thanks, fixed.

Dave

> Applying: net: Introduce announce timer
> .git/rebase-apply/patch:159: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: migration: Add announce parameters
> Applying: virtio-net: Switch to using announce timer
> .git/rebase-apply/patch:20: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: migration: Switch to using announce timer
> .git/rebase-apply/patch:309: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: net: Add a network device specific self-announcement ability
> Applying: virtio-net: Allow qemu_announce_self to trigger virtio announcements
> Applying: qmp: Add announce-self command
> .git/rebase-apply/patch:28: new blank line at EOF.
> +
> .git/rebase-apply/patch:56: new blank line at EOF.
> +
> warning: 2 lines add whitespace errors.
> Applying: hmp: Add hmp_announce_self
> Applying: tests: Add a test for qemu self announcments
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
