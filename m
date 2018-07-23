Received: from eggs.gnu.org ([2001:4830:134:3::10]:52930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhTx1-0002FY-17
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhTwx-0000W9-3y
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:04:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fhTww-0000Us-V3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:04:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C977401EF01
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 06:04:01 +0000 (UTC)
Received: from [10.36.116.129] (ovpn-116-129.ams2.redhat.com [10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ADBC2026D65
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 06:04:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e29321cd-b679-2163-d669-e808d61f0955@redhat.com>
Date: Mon, 23 Jul 2018 08:03:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] patchew.org updated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi all,

Fam has just updated Patchew to run the latest version.  Changes include:

- a new, more compact look for series visualization

- each message in the series is shown in a separate page

- links to other messages in the series show whether the message has had
replies or not

- the interdiff (version comparison) functionality can detect reordered
patches, similar to "git-tbdiff"

- an initial version of the REST API (https://patchew.org/api/v1/)

- support for colored logs (not yet useful for QEMU)

- new search terms "is:pull" and "has:replies"

- many bug fixes

Thanks,

Paolo
