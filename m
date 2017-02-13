Received: from eggs.gnu.org ([2001:4830:134:3::10]:58786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFnV-00011q-VI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFnS-0008Qm-Qb
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:32:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdFnS-0008Qd-Ks
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:31:58 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB59D81F01
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 12:31:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170203160651.19917-4-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 3 Feb 2017 16:06:50 +0000")
References: <20170203160651.19917-1-dgilbert@redhat.com>
	<20170203160651.19917-4-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 13:31:50 +0100
Message-ID: <87h93y5l1l.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/4] tests/migration: Add test for
 VMSTATE_WITH_TMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add a test for VMSTATE_WITH_TMP to tests/test-vmstate.c
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

now the latest version O:-)
