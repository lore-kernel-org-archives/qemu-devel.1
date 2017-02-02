Received: from eggs.gnu.org ([2001:4830:134:3::10]:33392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZPkz-0004zg-4g
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZPkv-0006Ag-Qm
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:21:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cZPkv-0006AO-L4
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:21:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EDF8C049D5B
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 22:21:29 +0000 (UTC)
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
	<25c8a78b-1d81-2a62-61ac-722d22999c41@redhat.com>
	<1486048853.3484.21.camel@redhat.com>
	<1486073625.20628.57.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <09cd8d24-468b-fddc-e631-cac02ed190e3@redhat.com>
Date: Fri, 3 Feb 2017 00:21:26 +0200
MIME-Version: 1.0
In-Reply-To: <1486073625.20628.57.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com

On 02/03/2017 12:13 AM, Gerd Hoffmann wrote:
> On Do, 2017-02-02 at 16:20 +0100, Andrea Bolognani wrote:
>> On Thu, 2017-02-02 at 16:42 +0200, Marcel Apfelbaum wrote:


[...]
>
>>> I personally don't use them because every time I try, I
>>> find something with no config support....
>>
>> Is that so? Can you please test these new ones and see
>> whether they work for you?
>
> I think mst means that not all qemu command line switches are using

           ^^^
Marcel, not mst, but I am flattered  :)


> QemuOpts, and the ones which don't can't be used with -readconfig.
>

Yes, this is exactly what I meant, this is why I *personally*
don't find -readconfig usable.

Thanks,
Marcel

> cheers,
>   Gerd
>
