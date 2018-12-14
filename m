Received: from eggs.gnu.org ([2001:4830:134:3::10]:58723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXg8r-0006Ow-Li
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXg8n-0004i1-Jl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXg8n-0004hU-C7
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:36:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C5D231256CA
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:36:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 588C526DD8
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:36:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
Date: Fri, 14 Dec 2018 06:35:58 +0100
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 13 Dec 2018 19:43:08 +0100")
Message-ID: <87k1kcfz5t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/32] QAPI patches for 2018-12-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

NAK, expect v2 to correct the commit message accident pointed out by
Eric.
