Received: from eggs.gnu.org ([2001:4830:134:3::10]:34209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egahE-0002ZE-8G
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egagA-0004sb-6B
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:31:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egagA-0004qF-0k
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:30:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171211072110.9058-1-lprosek@redhat.com>
Date: Tue, 30 Jan 2018 19:30:39 +0100
In-Reply-To: <20171211072110.9058-1-lprosek@redhat.com> (Ladi Prosek's message
	of "Mon, 11 Dec 2017 08:21:06 +0100")
Message-ID: <87vafjyzao.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/4] ivshmem: MSI bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, geoff@hostfission.com, marcandre.lureau@redhat.com

Paolo, care to merge these fixes?
