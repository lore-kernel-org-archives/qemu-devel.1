Received: from eggs.gnu.org ([2001:4830:134:3::10]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8R7-00009k-2x
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8R3-0003bN-Et
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:57:45 -0500
References: <20180206182507.21753-1-vsementsov@virtuozzo.com>
	<20180206182629.GQ20001@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <55cf676e-eae0-e694-c89b-778b0225730b@redhat.com>
Date: Tue, 6 Feb 2018 12:57:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180206182629.GQ20001@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 02/06/2018 12:26 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 06, 2018 at 09:25:07PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>> Support default luks options in VM.add_drive and in new library
>> function qemu_img_create. Use it in 205 iotests.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>=20
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Thanks. I'll take this through my NBD queue.

git git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
