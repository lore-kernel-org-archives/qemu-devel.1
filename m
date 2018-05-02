Received: from eggs.gnu.org ([2001:4830:134:3::10]:59380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDn9Q-0003hd-TP
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDn9N-00072N-Sd
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:30:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDn9N-00070Y-OP
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:30:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 299304022909
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 08:30:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180426152805.8469-1-armbru@redhat.com>
Date: Wed, 02 May 2018 10:30:07 +0200
In-Reply-To: <20180426152805.8469-1-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 26 Apr 2018 17:28:05 +0200")
Message-ID: <87vac6794g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qobject: Use qobject_to() instead of type
 cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Applied to qapi-next.
