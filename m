Received: from eggs.gnu.org ([2001:4830:134:3::10]:45287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cNzoc-0000WY-QG
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 05:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cNzoY-0004jr-UK
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 05:26:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cNzoY-0004jR-Of
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 05:26:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3E4F13A5D
	for <qemu-devel@nongnu.org>; Mon,  2 Jan 2017 10:26:02 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4315c23d-0c4b-4341-90aa-54d186eaa251@redhat.com>
Date: Mon, 2 Jan 2017 11:26:00 +0100
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/54] WIP: chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 12/12/2016 23:42, Marc-Andr=C3=A9 Lureau wrote:
>=20
> Note: this series has been tested with Linux and cross-building with
> mingw. It mostly breaks on other platforms,

What breaks exactly?

Paolo

> help welcome for
> testing. I'd also like to write more chardev backend tests to ensure
> no regression (test-char.c is quite limited for now)
