Received: from eggs.gnu.org ([2001:4830:134:3::10]:32938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVewe-0006nQ-2B
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVewd-0003ck-AZ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:46:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVewd-0003cU-4q
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:46:03 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47AA87E9C8
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 13:46:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1485178976-15225-1-git-send-email-pagupta@redhat.com> (Pankaj
	Gupta's message of "Mon, 23 Jan 2017 19:12:56 +0530")
References: <1485178976-15225-1-git-send-email-pagupta@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Jan 2017 14:45:59 +0100
Message-ID: <87tw8pc2js.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] migration: Change name of live
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com

Pankaj Gupta <pagupta@redhat.com> wrote:
> Change the name of live migration thread from 'migration'
> to 'live_migration' to identify it clearly. 'migration'
> is a generic word and kernel also has  tasks for process
> migration with the name 'migration/cpu#'.
>
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
