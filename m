Received: from eggs.gnu.org ([2001:4830:134:3::10]:36641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNfPt-0005QJ-2F
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNfPn-0001pM-TP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:48:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNfPn-0001oU-Md
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:48:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-8-david@redhat.com>
Date: Fri, 16 Nov 2018 15:48:06 +0100
In-Reply-To: <20181115140501.7872-8-david@redhat.com> (David Hildenbrand's
	message of "Thu, 15 Nov 2018 15:04:59 +0100")
Message-ID: <87va4x2i55.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 7/9] test-string-input-visitor: use
 virtual walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> We now support virtual walks, so use that instead.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
