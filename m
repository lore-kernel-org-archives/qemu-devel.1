Received: from eggs.gnu.org ([2001:4830:134:3::10]:60597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhAxK-0004Bj-JY
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhAxG-0002wC-Mo
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhAxG-0002vv-GL
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:42:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B11710F2C
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 08:42:33 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-172.ams2.redhat.com
	[10.36.116.172])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4052B18252
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 08:42:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Aug 2017 10:42:30 +0200
Message-Id: <20170814084231.10342-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Doc fix for QEMU 2.10-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 95766c2cd04395e5712b4d5967b3251f35d537df:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-08-10 18:53:39 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 69001917752fae95862db2d115cbf762afb0659c:

  qemu-doc: Fix "-net van" typo (2017-08-14 10:41:42 +0200)

----------------------------------------------------------------
* Lone typo fix (Thomas)

----------------------------------------------------------------
Thomas Huth (1):
      qemu-doc: Fix "-net van" typo

 qemu-doc.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-- 
2.13.3
