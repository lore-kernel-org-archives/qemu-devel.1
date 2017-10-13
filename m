Received: from eggs.gnu.org ([2001:4830:134:3::10]:38861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e2vyo-0004pI-TB
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e2vyk-00033i-Mq
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:10:06 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:36666
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1e2vyk-0002yx-Gb
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:10:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id C6FE3DA8325
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 11:10:00 +0200 (CEST)
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
	by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id OZOEPlurPGPh for <qemu-devel@nongnu.org>;
	Fri, 13 Oct 2017 11:09:59 +0200 (CEST)
Received: from [134.155.36.73] (edv13.bib.uni-mannheim.de [134.155.36.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id DBA07DA1F6B
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 11:09:59 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
Date: Fri, 13 Oct 2017 11:10:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] German BSI analysed security of KVM / QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>

Hi,

the German Bundesamt f=C3=BCr Sicherheit in der Informationstechnik
(Federal Office for Information Security) published a study on
the security of KVM and QEMU:

https://www.bsi.bund.de/DE/Publikationen/Studien/Sicherheitsanalyse_KVM/s=
icherheitsanalyse_kvm.html

(article only available in German)

Summary (Google translated to English):

"In summary, it can be said that the investigated components - above all
KVM, QEMU and libvirt - are suitable for realizing a technically mature
and secure virtualization environment."

Regards
Stefan Weil
