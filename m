Received: from eggs.gnu.org ([2001:4830:134:3::10]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cJfme-00036Q-Uv
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cJfma-0004lM-1m
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:14:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:56279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1cJfmZ-0004kJ-O0
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:14:07 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 59730ABB0
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 12:14:04 +0000 (UTC)
Date: Wed, 21 Dec 2016 13:14:03 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20161221131403.0718dd35@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QXL VGA on ppc64?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I heard this configuration is not working very well.

However, just enabling QXL in configuration and spapr.c I get a kvm
emulation error.

So what issues does the configuration have and what is needed to enable
it?

I am interested in resizing guest display to match client screen size.

Thanks

Michal
