Received: from eggs.gnu.org ([2001:4830:134:3::10]:56476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZtB8-0008QI-Hd
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZtB7-00031x-Om
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:18:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <7fb8c9ff25d183cf7c0f729a90ee4f59c0632d64.1497602554.git.maozy.fnst@cn.fujitsu.com>
	<38f43362-e3a3-44ab-9c29-d04b4c825085@redhat.com>
	<ee87c1b8-d34d-566e-b7cf-3c5700d76352@cn.fujitsu.com>
Date: Tue, 25 Jul 2017 08:18:31 +0200
In-Reply-To: <ee87c1b8-d34d-566e-b7cf-3c5700d76352@cn.fujitsu.com> (Mao
	Zhongyi's message of "Tue, 25 Jul 2017 09:16:59 +0800")
Message-ID: <87pocpxcnc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] util: remove the obsolete
 non-blocking connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, mreitz@redhat.com, Cao jin <caoj.fnst@cn.fujitsu.com>, kraxel@redhat.com, pbonzini@redhat.com, famz@redhat.com, sheepdog@lists.wpkg.org, "Daniel P. Berrange" <berrange@redhat.com>

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> On 07/25/2017 06:07 AM, John Snow wrote:
>> This was posted over a month ago with two R-Bs, did it get merged or dropped?
>>
>> --js
>
> Not yet, I hope that it will.

get_maintainers.pl blames Daniel, Gerd and Paolo :)
