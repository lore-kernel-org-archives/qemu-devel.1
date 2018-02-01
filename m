Received: from eggs.gnu.org ([2001:4830:134:3::10]:36390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCoq-0003Bd-Ix
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCom-0002CO-0u
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehCol-0002Aw-RU
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:14:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEFB668D9
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 11:14:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180201084535.26721-1-kraxel@redhat.com>
Date: Thu, 01 Feb 2018 12:14:05 +0100
In-Reply-To: <20180201084535.26721-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Thu, 1 Feb 2018 09:45:35 +0100")
Message-ID: <87mv0tq7wi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] vnc: use stubs for CONFIG_VNC=n dummy
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Cool!

Reviewed-by: Markus Armbruster <armbru@redhat.com>
