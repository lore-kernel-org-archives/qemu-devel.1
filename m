Received: from eggs.gnu.org ([2001:4830:134:3::10]:57785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gaurav.poothia@gmail.com>) id 1eOg9d-0004Em-Pl
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 03:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gaurav.poothia@gmail.com>) id 1eOg9c-00035N-T4
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 03:43:09 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gaurav.poothia@gmail.com>)
	id 1eOg9c-00034R-ME
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 03:43:08 -0500
Received: by mail-wm0-x22a.google.com with SMTP id 64so18700573wme.3
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 00:43:06 -0800 (PST)
MIME-Version: 1.0
From: Gaurav Poothia <gaurav.poothia@gmail.com>
Date: Tue, 12 Dec 2017 00:43:04 -0800
Message-ID: <CADDfC=q05U0NN5vTu08M-maV9HyT9f8o9sXcRSdgc8_dnFE4Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Cross version migration question (RH specific)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com

Hi,
I have some dumb questions about this Red Hat cross version migration
support matrix:
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-kvm_live_migration-live_migration_and_red_hat_enterprise_linux_version_compatibility_

Questions:
- Are all RHEL 7.x running the same version of QEMU?
- Then the forward and backward migration support across minor
releases (rows 3 and 4 in grid) is trivial right?
- Does RHEV-H rev the QEMU versions more aggressively across minor versions?
- Where can I find a similar cross version migration support matrix for RHEV?


Thanks!
Gaurav


-- 
Kiva.org - Loans That Change Lives
