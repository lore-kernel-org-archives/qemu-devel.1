Received: from eggs.gnu.org ([2001:4830:134:3::10]:57699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpcJL-0002Bn-Tx
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpcJH-0001Zl-HE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:32:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpcJH-0001Wk-Bq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:32:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4563680473
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1504696921.git.mprivozn@redhat.com>
Date: Wed, 06 Sep 2017 17:32:08 +0200
In-Reply-To: <cover.1504696921.git.mprivozn@redhat.com> (Michal Privoznik's
	message of "Wed, 6 Sep 2017 13:24:37 +0200")
Message-ID: <874lsfvo5j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/3] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, "Richard W. M. Jones" <rjones@redhat.com>

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Perhaps Rich would like to have a look, too.
