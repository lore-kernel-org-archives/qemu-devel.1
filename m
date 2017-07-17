Received: from eggs.gnu.org ([2001:4830:134:3::10]:51250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXC0O-0006Du-97
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXC0K-0007NA-RE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXC0K-0007N6-L5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:48:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B4C061E51
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 19:48:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-12-git-send-email-peterx@redhat.com> (Peter
	Xu's message of "Mon, 17 Jul 2017 16:26:11 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-12-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 21:48:26 +0200
Message-ID: <87d18yn8tx.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 11/11] migration: check global caps for
 validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Checks validity for all the capabilities that we enabled with command
> line.  Stop the VM if detected anything wrong.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
