Received: from eggs.gnu.org ([2001:4830:134:3::10]:46055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSLbD-0006rt-OM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSLbA-0001kv-LB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:07:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSLbA-0001kj-H2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E46180401A8
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 12:07:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
Date: Mon, 11 Jun 2018 14:06:58 +0200
In-Reply-To: <20180608130846.22234-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 8 Jun 2018 14:08:39 +0100")
Message-ID: <87a7s1il25.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Reenable hmp for preconfig mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

Let's also provide "quit", both in HMP and QMP.
