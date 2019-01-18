Received: from eggs.gnu.org ([209.51.188.92]:50151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkRLk-0005rj-2U
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkRLj-0000mP-C0
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51902 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkRLj-0000hF-4D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:26:07 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 11:25:53 +0100
Message-Id: <1547807155-4526-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/2] contrib: gitdm: Some updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add Citrix, Huawei, Intel, and Microsoft to domain map, and
update Wave Computuing group.

Aleksandar Markovic (2):
  contrib: gitdm: Update domain-map
  contrib: gitdm: Update Wave Computing group

 contrib/gitdm/domain-map         |  4 ++++
 contrib/gitdm/group-map-wavecomp | 12 ++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.7.4
