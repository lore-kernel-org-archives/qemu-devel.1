Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cEsfE-00076Z-FK
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 01:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cEsfB-0007O1-D9
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 01:58:44 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:9007 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cEsfB-0007I8-1F
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 01:58:41 -0500
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
	<C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ee7fc746-eb1d-3f89-df3c-308a2dd4a026@virtuozzo.com>
Date: Thu, 8 Dec 2016 09:58:23 +0300
MIME-Version: 1.0
In-Reply-To: <C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>, John Snow <jsnow@redhat.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Pargmann <mpa@pengutronix.de>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Wouter Verhelst <w@uter.be>, Paolo Bonzini <pbonzini@redhat.com>

08.12.2016 06:39, Alex Bligh wrote:

[...]

>> are vendor dependent extensions. The 'BASE' namespace represents
>> metadata contexts defined within this document. Other namespaces
>> may be registered by reference within this document.
>>
>> +The "BASE:allocation"
>>
>> Backticks: `BASE:allocation`

An idea: let's not use uppercase. Why to shout the namespace? 'base' and 
'x-' would be better I think. BASE and X- will provoke all user-defined 
namespaces be in uppercase too and a lot of uppercase will come to the 
code =(


-- 
Best regards,
Vladimir
