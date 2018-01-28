Received: from eggs.gnu.org ([2001:4830:134:3::10]:47881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efsQ8-0003f1-LL
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 14:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efsQ5-0002v9-EH
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 14:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1efsQ5-0002ui-8r
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 14:15:13 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1516620999-25669-1-git-send-email-wei.w.wang@intel.com> (Wei
	Wang's message of "Mon, 22 Jan 2018 19:36:39 +0800")
References: <1516620999-25669-1-git-send-email-wei.w.wang@intel.com>
Reply-To: quintela@redhat.com
Date: Sun, 28 Jan 2018 20:15:11 +0100
Message-ID: <87o9ldre0w.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] migration: use s->threshold_size inside
 migration_update_counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

Wei Wang <wei.w.wang@intel.com> wrote:
> Fixes: b15df1ae50 ("migration: cleanup stats update into function")
> The threshold size is changed to be recorded in s->threshold_size.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
