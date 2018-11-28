Received: from eggs.gnu.org ([2001:4830:134:3::10]:36502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3dJ-0002Uo-VD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3cs-0004Ds-FB
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gS3cq-00040t-CK
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:27:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64026C05D3E1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:27:46 +0000 (UTC)
References: <20181128153526.10948-1-berrange@redhat.com>
	<31667b3c-0071-e2b3-63d1-2fdc0c96c98f@redhat.com>
	<20181128172001.GV24355@redhat.com>
	<f027ff7a-de22-ba85-5737-68599cddadce@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb67e8e2-5a86-b3d3-a745-fb1b7614f40b@redhat.com>
Date: Wed, 28 Nov 2018 11:27:45 -0600
MIME-Version: 1.0
In-Reply-To: <f027ff7a-de22-ba85-5737-68599cddadce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 11/28/18 11:23 AM, Eric Blake wrote:

> 
> ...I have a live local server.
> 
> Tested-by: Eric Blake <eblake@redhat.com>

I'd also update .gitignore to exclude .bundle/ and vendor/, since those 
now show up as untracked after my testing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
