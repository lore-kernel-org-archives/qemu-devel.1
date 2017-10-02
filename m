Received: from eggs.gnu.org ([2001:4830:134:3::10]:43223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dywPF-0006Bz-F5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dywP9-0002ak-KW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dywP9-0002ad-EP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B72B7E426
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 08:48:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
	<20170927203225.30896-2-ehabkost@redhat.com>
Date: Mon, 02 Oct 2017 10:48:44 +0200
In-Reply-To: <20170927203225.30896-2-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 27 Sep 2017 17:32:24 -0300")
Message-ID: <87y3ouoryr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Eliminate defconfig variable
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Both -nodefconfig and -no-user-config options do the same thing
> today, we only need one variable to keep track of them.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
