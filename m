Received: from eggs.gnu.org ([2001:4830:134:3::10]:45947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4h4-0004bs-DD
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4h0-0006Rx-Jk
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:30:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4h0-0006R8-F3
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:30:10 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50a3963f-b6be-8807-b2f3-f45bac928d58@redhat.com>
Date: Fri, 27 Jul 2018 10:30:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/23] qobject: New
 qobject_from_vjsonf_nofail(), qdict_from_vjsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> Every printf()-like function sooner or later needs its vprintf()-like
> buddy.  The next commit will need qobject_from_jsonf_nofail()'s buddy,
> and qdict_from_jsonf_nofail()'s buddy will be used later in this
> series.  Add both.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
