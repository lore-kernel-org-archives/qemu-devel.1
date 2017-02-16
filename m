Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ceeaM-00022B-I1
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ceeaH-00086X-De
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:12:14 -0500
Received: from mail-db5eur01on0102.outbound.protection.outlook.com
	([104.47.2.102]:57698
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1ceeaG-000858-Mg
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:12:09 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 16 Feb 2017 20:39:19 +0300
Message-ID: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/1] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@openvz.org, anton.nefedov@virtuozzo.com

This patch is a follow-up for:

http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03647.html
