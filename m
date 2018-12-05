Received: from eggs.gnu.org ([2001:4830:134:3::10]:55818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUWQt-0006Ji-RY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUWQq-000337-Md
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:37:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUWQq-00032f-F0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:37:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEDA980F82
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 12:37:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
Date: Wed, 05 Dec 2018 13:37:22 +0100
In-Reply-To: <20181204131802.16885-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 4 Dec 2018 17:17:56 +0400")
Message-ID: <875zw8up31.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/6] monitor: misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Looks ready except for a few commit message tweaks and the proposed
assertion tweak in 3/6.
