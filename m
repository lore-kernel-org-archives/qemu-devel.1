Received: from eggs.gnu.org ([2001:4830:134:3::10]:46347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1f2vae-0007hf-Vd
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 05:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1f2vab-0002cu-0E
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 05:17:24 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:45535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1f2vaa-0002ae-SX
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 05:17:20 -0400
Received: by mail-ua0-f173.google.com with SMTP id j18so8521404uae.12
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 02:17:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <277c755c-f777-03ac-7288-50d00d6e9bc8@amsat.org>
References: <152248705425.873.8800157035194343108@71c20359a636>
	<277c755c-f777-03ac-7288-50d00d6e9bc8@amsat.org>
From: Fam Zheng <famz@redhat.com>
Date: Mon, 2 Apr 2018 17:16:38 +0800
Message-ID: <CAK1Eb9mkR=QjDsjWU8CaeRf2gMZ61ZTrUz-fXriz5DuhaJcLMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/18] QEMU validator: A method to specify
 QEMU crash-test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: patchew-devel@redhat.com, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 2, 2018 at 7:10 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> [/var]/tmp full due to some jobs not cleaning well their workspaces?

Somehow our "make check" now keeps hanging in the container,
preventing it from being cleaned up correctly...

Will try to find time for it this week.

Fam

>
> On 03/31/2018 06:04 AM, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series failed docker-build@min-glib build test. Please find the tes=
ting commands and
>> their output below. If you have Docker installed, you can probably repro=
duce it
>> locally.
>>
>> N/A. Internal error while reading log file
>>
>>
>>
>> ---
>> Email generated automatically by Patchew [http://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
>>
