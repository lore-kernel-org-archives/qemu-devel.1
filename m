Received: from eggs.gnu.org ([2001:4830:134:3::10]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chLO0-0002Xh-BD
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chLNv-0000DM-Df
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chLNv-0000BX-7i
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:18:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EC36C05AA61
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 19:18:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170222180423.26571-1-pbonzini@redhat.com>
	<20170222180423.26571-2-pbonzini@redhat.com>
	<87d1e7abbb.fsf@dusky.pond.sub.org>
	<09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
Date: Fri, 24 Feb 2017 20:18:28 +0100
In-Reply-To: <09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com> (Paolo
	Bonzini's message of "Fri, 24 Feb 2017 16:29:27 +0100")
Message-ID: <877f4f2y9n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

[...]
> I'm leaving these three patches out of the pull request (and 2.9) while
> the discussion goes on.

Appreciated!  Please remind me to come back to this discussion once the
freeze madness has died down.
