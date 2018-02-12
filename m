Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMZX-0001TI-RU
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMZT-0000RX-7c
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:27:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elMZT-0000Qx-2L
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:27:35 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-26-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a991f204-3e20-aeac-d6bb-c9ec5ce00901@redhat.com>
Date: Mon, 12 Feb 2018 16:27:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 25/29] docs/devel/writing-qmp-commands:
 Update for modular QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:36 AM, Markus Armbruster wrote:
> With modular code generation, putting stuff right into
> qapi-schema.json is a bad idea.  Update writing-qmp-commands.txt
> accordingly.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/devel/writing-qmp-commands.txt | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
