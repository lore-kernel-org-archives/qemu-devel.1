Received: from eggs.gnu.org ([2001:4830:134:3::10]:49803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAY9V-0000FM-O8
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAY9S-0003fK-NL
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:52:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fAY9S-0003ey-Id
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CBE08182D19
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:52:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180420231246.23130-1-lersek@redhat.com>
	<20180420231246.23130-2-lersek@redhat.com>
Date: Mon, 23 Apr 2018 11:52:44 +0200
In-Reply-To: <20180420231246.23130-2-lersek@redhat.com> (Laszlo Ersek's
	message of "Sat, 21 Apr 2018 01:12:44 +0200")
Message-ID: <87tvs2ntar.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [qemu RFC v3 1/3] qapi: add SysEmuTarget to
 "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

Laszlo Ersek <lersek@redhat.com> writes:

> We'll soon need an enumeration type that lists all the softmmu targets
> that QEMU (the project) supports. Introduce @SysEmuTarget to
> "common.json".
>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: David Gibson <dgibson@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
