Received: from eggs.gnu.org ([2001:4830:134:3::10]:33014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLlM-0002C9-T1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLlK-0002mc-6h
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:50:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daLlK-0002mP-0Z
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:50:02 -0400
Message-ID: <1501073395.29903.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 14:49:55 +0200
In-Reply-To: <e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
References: <150107094952.114.932926322923994155@5d477a5b5989>
	<e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, no-reply@patchew.org
Cc: famz@redhat.com, Markus Armbruster <armbru@redhat.com>

  Hi,

> error message).=C2=A0=C2=A0I suspect this is caused by your use of '@ac=
_*'
> instead
> of spelling out all the ac_ members added in qapi-schema.json in 4/5
> -

Hmm, adding them all will be a pretty long list, and it will probably
become alot longer when we add more missing keys in 2.11 ...

Should this maybe summarized along the lines of "# multimedia keys
added in 2.10"?

cheers,
  Gerd
