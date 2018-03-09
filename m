Received: from eggs.gnu.org ([2001:4830:134:3::10]:58174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euIwm-0007wk-Se
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euIwi-0006N8-PW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:24:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euIwi-0006N0-KZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:24:32 -0500
References: <20180226075846.20307-1-famz@redhat.com>
	<20180226075846.20307-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0deeab65-9c94-c4e2-7dba-a254b185d5d9@redhat.com>
Date: Fri, 9 Mar 2018 08:24:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180226075846.20307-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: Use query-usernet instead of
 'info usernet'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 02/26/2018 01:58 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   tests/vm/basevm.py | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

I think this series can go through either my QAPI tree, or through the 
Jason's net tree, once v3 fixes the issues I pointed out on 1/2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
