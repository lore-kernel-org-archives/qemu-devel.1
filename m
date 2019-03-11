Received: from eggs.gnu.org ([209.51.188.92]:55122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3Nmu-00057v-QH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3Nmq-0007cI-27
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3Nmp-0007ax-PT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:28:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49F703082DDD
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 16:28:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1552319784-31755-1-git-send-email-pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:28:20 +0100
In-Reply-To: <1552319784-31755-1-git-send-email-pbonzini@redhat.com> (Paolo
	Bonzini's message of "Mon, 11 Mar 2019 16:56:24 +0100")
Message-ID: <878sxljryz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemugdb: fix licensing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> qemu-gdb.py was committed after 2012-01-13, so the notice about
> GPL v2-only contributions does not apply.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Appreciated!

Reviewed-by: Markus Armbruster <armbru@redhat.com>
