Received: from eggs.gnu.org ([2001:4830:134:3::10]:38215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df05w-0007rI-Id
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df05u-0001HZ-KG
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df05u-0001H9-E7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:42:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B9977F40F
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 08:42:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170719154434.GE3500@work-vm> (David Alan Gilbert's message of
	"Wed, 19 Jul 2017 16:44:34 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-5-quintela@redhat.com>
	<20170719154434.GE3500@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 10:42:25 +0200
Message-ID: <87k22ebgcu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 04/17] migration: Add multifd capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Note you need to update this;  you need to add the
> DEFINE_PROP_MIG_CAP in migration_properties[]

Done, it was sent before I integrated the other patches into upstream.
