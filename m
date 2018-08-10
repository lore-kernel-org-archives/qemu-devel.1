Received: from eggs.gnu.org ([2001:4830:134:3::10]:38289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9ov-0007Y2-Hu
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9os-0006Nm-Gb
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:59:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo9os-0006NH-BF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:59:18 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-27-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b2bc2b5-9b41-d673-ea9b-367ea8b505fa@redhat.com>
Date: Fri, 10 Aug 2018 10:59:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-27-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/56] json: Simplify parse_string()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-parser.c | 42 +++++++++++++++++++-----------------------
>   1 file changed, 19 insertions(+), 23 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
